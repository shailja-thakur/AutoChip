module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [3:0] state;
reg last_byte;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        state <= 0;
        done <= 0;
        last_byte <= 0;
    end else begin
        case(state)
            0: begin
                if(in[3] == 1) begin
                    state <= 1;
                    last_byte <= 0;
                end else begin
                    state <= 0;
                    last_byte <= 0;
                end
            end
            1: begin
                if(in[3] == 1) begin
                    state <= 2;
                    last_byte <= 0;
                end else begin
                    state <= 1;
                    last_byte <= 0;
                end
            end
            2: begin
                if(in[3] == 1) begin
                    state <= 0;
                    last_byte <= 1;
                    done <= 1;
                end else begin
                    state <= 0;
                    last_byte <= 0;
                end
            end
            default: begin
                state <= 0;
                last_byte <= 0;
            end
        endcase
    end
end

endmodule
