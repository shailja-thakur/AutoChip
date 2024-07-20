module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;

parameter OFF = 2'b00;
parameter ON = 2'b01;

always @(posedge clk) begin
    if (reset) begin
        state <= OFF;
        out <= 0;
    end else begin
        case (state)
            OFF: begin
                if (j) begin
                    state <= ON;
                end else begin
                    state <= OFF;
                end
            end
            ON: begin
                if (k) begin
                    state <= OFF;
                end else begin
                    state <= ON;
                end
            end
        endcase
        
        case (state)
            OFF: out <= 0;
            ON: out <= 1;
        endcase
    end
end

endmodule
