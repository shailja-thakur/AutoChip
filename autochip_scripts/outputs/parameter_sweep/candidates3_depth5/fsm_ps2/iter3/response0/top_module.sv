module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [3:0] state;
reg last_byte;
reg prev_in3;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        state <= 0;
        done <= 0;
        last_byte <= 0;
        prev_in3 <= 0;
    end else begin
        case(state)
            0: begin
                if(in[3] == 1 && prev_in3 == 0) begin
                    state <= 1;
                    last_byte <= 0;
                end else begin
                    state <= 0;
                    last_byte <= 0;
                end
                prev_in3 <= in[3];
            end
            1: begin
                if(in[3] == 0 && prev_in3 == 1) begin
                    state <= 2;
                    last_byte <= 0;
                end else begin
                    state <= 0;
                    last_byte <= 0;
                end
                prev_in3 <= in[3];
            end
            2: begin
                if(in[3] == 1 && prev_in3 == 0) begin
                    done <= 1;
                    state <= 0;
                    last_byte <= 1;
                end else begin
                    state <= 0;
                    last_byte <= 0;
                end
                prev_in3 <= in[3];
            end
            default: begin
                state <= 0;
                last_byte <= 0;
                prev_in3 <= 0;
            end
        endcase
    end
end

endmodule
