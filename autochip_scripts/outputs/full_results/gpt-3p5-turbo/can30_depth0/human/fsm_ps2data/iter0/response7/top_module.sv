module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [1:0] state;
reg [23:0] message;
reg out_valid;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        message <= 0;
        out_valid <= 0;
    end else begin
        case (state)
            2'b00: begin
                if (in[3] == 1) begin
                    state <= 2'b01;
                    message[23:16] <= in;
                end else begin
                    state <= 2'b00;
                end
            end

            2'b01: begin
                state <= 2'b10;
                message[15:8] <= in;
            end
            
            2'b10: begin
                state <= 2'b11;
                message[7:0] <= in;
                out_valid <= 1;
            end

            2'b11: begin
                state <= 2'b00;
                out_valid <= 0;
                message <= 0;
            end

            default: begin
                state <= 2'b00;
            end
        endcase
    end
end

assign done = out_valid;
assign out_bytes = out_valid ? message : 0;

endmodule
