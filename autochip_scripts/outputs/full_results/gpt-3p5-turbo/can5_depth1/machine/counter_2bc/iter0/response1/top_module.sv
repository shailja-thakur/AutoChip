module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;  // reset to state 1
        end else begin
            case ({train_valid, train_taken})
                2'b10: begin  // taken and current state < 3
                    if (state < 2'b11) begin
                        state <= state + 1;  // transition to next state
                    end
                end
                2'b00: begin  // not taken and current state > 0
                    if (state > 2'b00) begin
                        state <= state - 1;  // transition to previous state
                    end
                end
                default: begin  // no transition
                    state <= state;
                end
            endcase
        end
    end
endmodule
