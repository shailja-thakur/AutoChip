module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    reg [1:0] state;  // parameterized register to store the current state
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b01;  // initial state B
        end else begin
            case (state)
                2'b00: begin  // state A
                    if (in) begin
                        state <= 2'b00;  // next state A
                    end else begin
                        state <= 2'b01;  // next state B
                    end
                end
                
                2'b01: begin  // state B
                    if (in) begin
                        state <= 2'b01;  // next state B
                    end else begin
                        state <= 2'b00;  // next state A
                    end
                end
            endcase
        end
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;  // assign output based on state
    
endmodule
