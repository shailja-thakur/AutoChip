module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        byte1 <= 8'h00;
        byte2 <= 8'h00;
        byte3 <= 8'h00;
        state <= 3'b000;
        done <= 1'b0;
    end else begin
        case(state)
            3'b000: begin
                if (in[3] == 1'b1) begin
                    byte1 <= in;
                    state <= 3'b001;
                end
            end
            3'b001: begin
                byte2 <= in;
                state <= 3'b010;
            end
            3'b010: begin
                byte3 <= in;
                state <= 3'b011;
            end
            3'b011: begin
                done <= 1'b1;
                state <= 3'b100;
            end
            3'b100: begin
                done <= 1'b0;
                state <= 3'b000;
            end
        endcase
    end
end

endmodule
