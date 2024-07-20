module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [1:0] state;
    reg [7:0] reg_in;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            reg_in <= 0;
            out_bytes <= 0;
            done <= 0;
        end else begin
            case (state)
                BYTE1: begin
                    if (in[2] == 1) begin
                        state <= BYTE2;
                    else
                        state <= BYTE1;
                    end
                    reg_in <= in;
                end
                    
                BYTE2: begin
                    state <= BYTE3;
                    reg_in <= in;
                end

                BYTE3: begin
                    state <= DONE;
                    reg_in <= in;
                end

                DONE: begin
                    if (in[2] == 0) begin
                        state <= BYTE1;
                    end
                    reg_in <= in;
                    done <= 1;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (done) begin
            out_bytes <= {reg_in, reg_in, reg_in};
        end
    end

endmodule
