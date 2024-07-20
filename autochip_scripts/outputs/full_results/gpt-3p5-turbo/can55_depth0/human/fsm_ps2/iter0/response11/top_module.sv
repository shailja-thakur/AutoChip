module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg [7:0] byte_counter;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        byte_counter <= 0;
        done <= 0;
    end else begin
        case (state)
            2'b00: begin
                if (in[3] == 1)
                    state <= 2'b01;
                else
                    state <= 2'b00;
            end
            2'b01: begin
                state <= 2'b10;
            end
            2'b10: begin
                if (byte_counter == 2) begin
                    state <= 2'b11;
                    byte_counter <= 0;
                    done <= 1;
                end else begin
                    state <= 2'b01;
                    byte_counter <= byte_counter + 1;
                end
            end
            2'b11: begin
                state <= 2'b00;
                done <= 0;
            end
        endcase
    end
end

endmodule
