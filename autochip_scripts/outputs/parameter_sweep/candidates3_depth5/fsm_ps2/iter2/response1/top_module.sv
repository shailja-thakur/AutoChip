module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [3:0] state;
reg [7:0] prev_in;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        state <= 0;
        done <= 0;
        prev_in <= 8'b0;
    end else begin
        case(state)
            0: begin
                if(in[3] == 1 && in != prev_in) begin
                    state <= 1;
                    prev_in <= in;
                end else begin
                    state <= 0;
                    prev_in <= in;
                end
            end
            1: begin
                if(in != prev_in) begin
                    state <= 2;
                    prev_in <= in;
                end else begin
                    state <= 1;
                    prev_in <= in;
                end
            end
            2: begin
                if(in[3] == 1 && in != prev_in) begin
                    done <= 1;
                    state <= 0;
                    prev_in <= in;
                end else begin
                    state <= 0;
                    prev_in <= in;
                end
            end
            default: begin
                state <= 0;
                prev_in <= in;
            end
        endcase
    end
end

endmodule
