module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);
    always @*
    begin
        case (state)
            2'b00: begin
                if (in == 1'b0) begin
                    next_state = 2'b00;
                    out = 1'b0;
                end
                else begin
                    next_state = 2'b01;
                    out = 1'b0;
                end
            end
            2'b01: begin
                if (in == 1'b0) begin
                    next_state = 2'b10;
                    out = 1'b0;
                end
                else begin
                    next_state = 2'b01;
                    out = 1'b0;
                end
            end
            2'b10: begin
                if (in == 1'b0) begin
                    next_state = 2'b00;
                    out = 1'b0;
                end
                else begin
                    next_state = 2'b11;
                    out = 1'b0;
                end
            end
            2'b11: begin
                if (in == 1'b0) begin
                    next_state = 2'b10;
                    out = 1'b1;
                end
                else begin
                    next_state = 2'b01;
                    out = 1'b0;
                end
            end
        endcase
    end
    
    initial
    begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_module);
        $display("Start simulation");
        $monitor("Time=%t state=%b in=%b next_state=%b out=%b", $time, state, in, next_state, out);
        
        // Test case 1
        state = 2'b00;
        in = 1'b0;
        #10;
        
        // Test case 2
        state = 2'b00;
        in = 1'b1;
        #10;
        
        // Test case 3
        state = 2'b01;
        in = 1'b0;
        #10;
        
        // Test case 4
        state = 2'b01;
        in = 1'b1;
        #10;
        
        // Test case 5
        state = 2'b10;
        in = 1'b0;
        #10;
        
        // Test case 6
        state = 2'b10;
        in = 1'b1;
        #10;
        
        // Test case 7
        state = 2'b11;
        in = 1'b0;
        #10;
        
        // test case 8
        state = 2'b11;
        in = 1'b1;
        #10;
        
        $display("Simulation finished");
        $finish;
    end
endmodule
