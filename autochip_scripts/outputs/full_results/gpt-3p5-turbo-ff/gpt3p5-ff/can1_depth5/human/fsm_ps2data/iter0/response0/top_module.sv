module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
    reg [7:0] state;
    reg [23:0] temp;
    reg [7:0] count;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            count <= 0;
            temp <= 0;
            done <= 0;
            out_bytes <= 0;
        end else begin
            case(state)
                0: begin // Waiting for in[3] to be 1
                    if (in[3] == 1) begin
                        state <= 1;
                        temp <= in;
                        count <= count + 1;
                    end
                end
                1: begin // Waiting for 3 bytes
                    if (count == 2) begin
                        out_bytes <= {temp, in};
                        done <= 1;
                        state <= 0;
                        count <= 0;
                        temp <= 0;
                    end else begin
                        count <= count + 1;
                        temp <= {temp[15:0], in};
                    end
                end
            endcase
        end
    end
endmodule
