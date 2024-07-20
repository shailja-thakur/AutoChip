module top_module (
        input clk,
        input in,
        input reset,
        output reg [7:0] out_byte,
        output reg done
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
    end else begin
        case (state)
            3'b000: if (!in) begin
                        state <= 3'b001;
                     end else begin
                        state <= 3'b000;
                     end;
            3'b001: begin
                      out_byte <= 8'b00000000;
                      state <= 3'b010;
                     end;
            3'b010: begin
                      out_byte <= {out_byte[6:0], in};
                      state <= 3'b011;
                     end;
            3'b011: begin
                      state <= 3'b100;
                     end;
            3'b100: if (in) begin
                        state <= 3'b101;
                     end else begin
                        state <= 3'b100;
                     end;
            3'b101: begin
                      done <= 1;
                      state <= 3'b000;
                     end;
        endcase
    end
end

endmodule
