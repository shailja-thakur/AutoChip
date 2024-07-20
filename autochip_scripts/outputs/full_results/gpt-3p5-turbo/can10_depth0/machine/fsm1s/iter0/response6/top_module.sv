module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    reg [1:0] state; // parameterized register to store the current state
    
    always @(posedge clk) begin // always block triggered on the rising edge of clk input
        if (reset) begin
            state <= 2'b1; // reset state register to initial state, B
        end else begin
            case(state)
                2'b00: begin // state A
                    if (in) begin
                        state <= 2'b00; // next state A if in input is high
                    end else begin
                        state <= 2'b01; // next state B if in input is low
                    end
                end
                2'b01: begin // state B
                    if (in) begin
                        state <= 2'b01; // next state B if in input is high
                    end else begin
                        state <= 2'b00; // next state A if in input is low
                    end
                end
                default: state <= 2'b01; // default state B
            endcase
        end
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0; // assign out output based on state register, out is high if state is B, otherwise it is low

endmodule
