module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [23:0] message;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        message <= 0;
        done <= 0;
        out_bytes <= 0;
    end else begin
        case (state)
            2'b00: begin
                if (in[3]) begin
                    state <= 2'b01;
                    message[23:16] <= in;
                end
            end
            2'b01: begin
                state <= 2'b10;
                message[15:8] <= in;
            end
            2'b10: begin
                state <= 2'b11;
                message[7:0] <= in;
                done <= 1;
                out_bytes <= message;
            end
            2'b11: begin
                if (done) begin
                    state <= 2'b00;
                    message <= 0;
                    done <= 0;
                    out_bytes <= 0;
                end
            end
        endcase
    end
end

endmodule
