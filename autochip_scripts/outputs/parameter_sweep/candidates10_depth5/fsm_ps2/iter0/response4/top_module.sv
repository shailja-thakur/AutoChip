module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [1:0] state;
reg [7:0] prev_byte;
reg done;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        done <= 0;
    end else begin
        case (state)
            2'b00: begin // Idle state
                if (in[3]) begin
                    prev_byte <= in;
                    state <= 2'b01;
                end
            end
            2'b01: begin // Receive second byte
                prev_byte <= in;
                state <= 2'b10;
            end
            2'b10: begin // Receive third byte
                if (in[3]) begin
                    prev_byte <= in;
                    done <= 1;
                end else begin
                    prev_byte <= in;
                    state <= 2'b01;
                end
            end
            default: begin
                state <= 2'b00;
                done <= 0;
            end
        endcase
    end
end

endmodule
