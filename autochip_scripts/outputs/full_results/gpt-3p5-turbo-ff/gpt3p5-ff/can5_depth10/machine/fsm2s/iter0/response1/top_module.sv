module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00; // initialize state to A
    end else begin
        case (state)
            2'b00: begin // state A
                if (j) begin
                    state <= 2'b01; // next state is B
                end else begin
                    state <= 2'b00; // next state remains A
                end
            end
            2'b01: begin // state B
                if (k) begin
                    state <= 2'b00; // next state is A
                end else begin
                    state <= 2'b01; // next state remains B
                end
            end
        endcase
    end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0; // output out is high when state is B, and low when state is A

endmodule
