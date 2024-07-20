module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state; // state register

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // reset state to B
    end else begin
        case(state)
            2'b00: begin // state A
                if (in) begin
                    state <= 2'b00; // next state is A
                end else begin
                    state <= 2'b01; // next state is B
                end
            end
            2'b01: begin // state B
                if (in) begin
                    state <= 2'b01; // next state is B
                end else begin
                    state <= 2'b00; // next state is A
                end
            end
        endcase
    end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0; // output is high when state is B, low otherwise

endmodule
