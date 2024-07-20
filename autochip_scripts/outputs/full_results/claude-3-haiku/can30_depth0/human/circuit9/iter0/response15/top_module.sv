module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

reg [1:0] state;

always @(posedge clk) begin
    case (state)
        2'b00: begin
            if (a) begin
                q <= 3'd4;
                state <= 2'b01;
            end
            else begin
                q <= 3'd0;
                state <= 2'b00;
            end
        end
        2'b01: begin
            if (a) begin
                q <= 3'd4;
                state <= 2'b01;
            end
            else begin
                q <= 3'd5;
                state <= 2'b10;
            end
        end
        2'b10: begin
            if (a) begin
                q <= 3'd0;
                state <= 2'b00;
            end
            else begin
                q <= 3'd6;
                state <= 2'b10;
            end
        end
        default: begin
            q <= 3'd0;
            state <= 2'b00;
        end
    endcase
end

endmodule
