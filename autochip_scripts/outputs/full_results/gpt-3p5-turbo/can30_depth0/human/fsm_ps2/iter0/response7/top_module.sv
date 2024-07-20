module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    
    reg [1:0] state;
    reg [7:0] byte_count;
    reg done_sig;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            byte_count <= 8'b0;
            done_sig <= 1'b0;
        end else begin
            case(state)
                2'b00: begin // IDLE state
                    done_sig <= 1'b0;
                    if (in[3] == 1'b1) begin
                        state <= 2'b01; // Byte 1 received
                        byte_count <= 8'b1;
                    end
                end
                
                2'b01: begin // Byte 1 received
                    byte_count <= byte_count + 8'b1;
                    if (byte_count == 8'b111) begin
                        state <= 2'b10; // Byte 3 received
                    end else begin
                        state <= 2'b00; // IDLE state
                    end
                end
                
                2'b10: begin // Byte 3 received
                    state <= 2'b00; // IDLE state
                    byte_count <= 8'b0;
                    done_sig <= 1'b1;
                end
            endcase
        end
    end
    
    assign done = done_sig;
    
endmodule
