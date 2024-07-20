module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// State variables
reg [1:0] state;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= A;
        out <= 0;
    end
    else begin
        case (state)
            A: begin
                if (in == 0) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
                out <= 0;
            end
            B: begin
                if (in == 0) begin
                    state <= C;
                end
                else begin
                    state <= B;
                end
                out <= 0;
            end
            C: begin
                if (in == 0) begin
                    state <= A;
                end
                else begin
                    state <= D;
                end
                out <= 0;
            end
            D: begin
                if (in == 0) begin
                    state <= C;
                end
                else begin
                    state <= B;
                end
                out <= 1;
            end
        endcase
    end
end

endmodule
