module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;  // declare a register to store the current state

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b10;  // initialize the state to 'B'
    end else begin
        case(state)
            2'b10: begin  // state B
                if (in) begin
                    state <= 2'b10;  // stay in state B
                end else begin
                    state <= 2'b01;  // move to state A
                end
            end
            2'b01: begin  // state A
                if (in) begin
                    state <= 2'b01;  // stay in state A
                end else begin
                    state <= 2'b10;  // move to state B
                end
            end
        endcase
    end
end

assign out = (state == 2'b10) ? 1'b1 : 1'b0;  // set output based on state

endmodule
