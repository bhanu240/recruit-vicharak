module sha_engine_tb(
    reg [31:0] word;         
    reg clk;                 
    reg rst;                  
    reg last_word;          
    reg [1:0] last_next;     
    wire [6:0] index;       
    wire [255:0] hash_data;  
    wire output_valid;       

    sha_engine uut (
        .word(word),
        .clk(clk),
        .rst(rst),
        .index(index),
        .last_word(last_word),
        .last_next(last_next),
        .hash_data(hash_data),
        .output_valid(output_valid)
    );

    
    always begin
        #5 clk = ~clk;
    end

    
    initial begin
      
        clk = 0;
        rst = 1;
        word = 32'b0;
        last_word = 0;
        last_next = 2'b00;
       
        #10 rst = 0; 
        #10 rst = 1; 

       #10 word = 32'h68656c6c; 
        last_word = 0;
        last_next = 2'b00;
       
        #10 word = 32'h6f000000; 
        last_word = 0;
        last_next = 2'b00;
       
        #10 word = 32'h80000000; 
        last_word = 0;
        last_next = 2'b01; 
       
        #10 word = 32'h00000000; 
        last_word = 0;
        last_next = 2'b01;
       
        #10 word = 32'h00000000; 
        last_word = 1; 
        last_next = 2'b01;
        #100;  
 if (output_valid) begin
            $display("Final SHA-256 hash: %h", hash_data);
        end else begin
            $display("Hash not yet valid.");
        end

       
        #10 $finish;
    end

 
    initial begin
        $monitor("At time %t, word = %h, index = %d, hash_data = %h, output_valid = %b",
                 $time, word, index, hash_data, output_valid);
    end

endmodule

