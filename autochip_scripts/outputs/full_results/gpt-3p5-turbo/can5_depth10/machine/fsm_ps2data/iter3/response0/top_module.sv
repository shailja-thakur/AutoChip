module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [3:0] state;
    reg [3:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 4'b0000;
        else
            state <= next_state;
    end

    always @(state, in) begin
        case (state)
            4'b0000: begin
                if (in[2] == 1)
                    next_state = 4'b0001;
                else
                    next_state = 4'b0000;
            end
            4'b0001: begin
                if (in[2] == 1)
                    next_state = 4'b0010;
                else
                    next_state = 4'b0000;
            end
            4'b0010: begin
                if (in[2] == 1)
                    next_state = 4'b1000;
                else
                    next_state = 4'b0000;
            end
            4'b1000: begin
                if (in[2] == 1)
                    next_state = 4'b1000;
                else
                    next_state = 4'b0001;
            end
            default: next_state = 4'b0000;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            done <= 0;
        end
        else if (state == 4'b1000) begin
            out_bytes <= in;
            done <= 1;
        end
        else begin
            out_bytes <= {out_bytes[15:0], in};
            done <= 0;
        end
    end
endmodule
