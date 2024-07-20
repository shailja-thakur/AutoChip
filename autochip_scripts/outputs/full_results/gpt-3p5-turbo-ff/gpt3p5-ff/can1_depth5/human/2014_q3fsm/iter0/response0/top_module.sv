module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // reset state A
    end else begin
        case (state)
            2'b00: begin // state A
                if (s) begin
                    state <= 2'b01; // move to state B
                end
            end
            2'b01: begin // state B
                state <= 2'b10; // transition to next state
            end
            2'b10: begin // check w for 3 cycles
                if (w) begin
                    state <= 2'b11;
                end
            end
            2'b11: begin // check w for 3 cycles
                state <= 2'b00;
            end
        endcase
    end
end

always @(posedge clk) begin
    if (state == 2'b11 && w) begin
        z <= 1;
    end else begin
        z <= 0;
    end
end

endmodule
