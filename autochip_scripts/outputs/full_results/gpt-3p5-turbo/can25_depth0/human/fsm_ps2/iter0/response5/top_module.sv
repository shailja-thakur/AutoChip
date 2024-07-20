module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [2:0] state;
    reg [7:0] reg_in;
    reg done;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            reg_in <= 0;
            done <= 0;
        end
        else begin
            case (state)
                0: begin // Idle state
                    if (in[3] == 1) begin
                        state <= 1;
                        reg_in <= in;
                    end
                end
                1: begin // Second byte state
                    state <= 2;
                end
                2: begin // Third byte state
                    if (in[3] == 1) begin
                        state <= 3;
                        done <= 1;
                    end
                    else begin
                        state <= 0;
                        reg_in <= 0;
                    end
                end
                3: begin // Done state
                    state <= 0;
                    reg_in <= 0;
                    done <= 0;
                end
            endcase
        end
    end

endmodule
