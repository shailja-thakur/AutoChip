module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [1:0] state;
reg done;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        byte1 <= 8'b0;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
        state <= 2'b00;
        done <= 1'b0;
    end else begin
        case (state)
            2'b00: begin
                if (in[3] == 1'b1) begin
                    byte1 <= in;
                    state <= 2'b01;
                end
            end
            
            2'b01: begin
                byte2 <= in;
                state <= 2'b10;
            end
            
            2'b10: begin
                byte3 <= in;
                state <= 2'b11;
                done <= 1'b1;
            end
            
            2'b11: begin
                if (in[3] == 1'b1) begin
                    byte1 <= in;
                    state <= 2'b01;
                else begin
                    byte1 <= in;
                    state <= 2'b00;
                end
            end
            
            default: begin
                state <= 2'b00;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
