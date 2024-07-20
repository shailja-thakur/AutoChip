module top_module (
    input clk,
    input [7:0] in,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define states
    typedef enum logic [1:0] {
        BYTE1, BYTE2, BYTE3, DONE
    } state_type;
    
    // Define current state
    reg [1:0] current_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            case (current_state)
                BYTE1: begin
                    if (in[2] == 1'b1) begin
                        current_state <= BYTE2;
                    end else begin
                        current_state <= BYTE1;
                    end
                    out_bytes <= {out_bytes[15:0], in};
                    if (done == 1) begin
                        done <= 0;
                    end
                end
                BYTE2: begin
                    if (in[2] == 1'b1) begin
                        current_state <= BYTE3;
                    end else begin
                        current_state <= BYTE1;
                    end
                    out_bytes <= {out_bytes[15:0], in};
                    if (done == 1) begin
                        done <= 0;
                    end
                end
                BYTE3: begin
                    if (in[2] == 1'b1) begin
                        current_state <= DONE;
                    end else begin
                        current_state <= BYTE1;
                    end
                    out_bytes <= {out_bytes[15:0], in};
                    if (done == 1) begin
                        done <= 0;
                    end
                end
                DONE: begin
                    current_state <= BYTE1;
                    out_bytes <= {out_bytes[15:0], in};
                    done <= 1;
                end
            endcase
        end
    end

endmodule
