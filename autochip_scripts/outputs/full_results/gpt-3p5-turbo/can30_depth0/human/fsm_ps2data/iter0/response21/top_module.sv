module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg done_reg;
reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        byte1 <= 8'b0;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
        done_reg <= 1'b0;
        state <= 3'b0;
    end else begin
        case (state)
            3'b000: begin // Waiting for in[3] = 1
                if (in[3] == 1'b1) begin
                    byte1 <= in;
                    state <= 3'b001;
                end
            end
            3'b001: begin // Receiving byte2
                byte2 <= in;
                state <= 3'b010;
            end
            3'b010: begin // Receiving byte3
                byte3 <= in;
                state <= 3'b011;
            end
            3'b011: begin // Waiting for in[3] = 1
                if (in[3] == 1'b1) begin
                    done_reg <= 1'b1;
                    state <= 3'b100;
                end
            end
            default: begin
                // Do nothing
            end
        endcase
    end
end

assign out_bytes = {byte1, byte2, byte3};
assign done = done_reg;

endmodule
