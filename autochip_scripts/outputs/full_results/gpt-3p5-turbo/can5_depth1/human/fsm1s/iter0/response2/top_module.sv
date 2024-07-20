module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
reg out_reg;

always @(posedge clk) begin
    if (reset)
        state <= 2'b10; // B state
    else begin
        case (state)
            2'b10: begin // B state
                if (in)
                    state <= 2'b10; // B state
                else
                    state <= 2'b01; // A state
            end
            2'b01: begin // A state
                if (in)
                    state <= 2'b01; // A state
                else
                    state <= 2'b10; // B state
            end
        endcase
    end
end

always @(*) begin
    case (state)
        2'b10: out_reg = 1'b1; // B state
        2'b01: out_reg = 1'b0; // A state
    endcase
end

assign out = out_reg;

endmodule
