module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);
	// Define states and their values
    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        DATA_BIT,
        STOP_BIT
    } state_type;
    
    // Define signals
    reg [2:0] state;
    reg [7:0] received_byte;
    reg done;
    
    // Synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            received_byte <= 8'b0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (in == 1'b0) begin
                        state <= START_BIT;
                        received_byte <= 8'b0;
                        done <= 0;
                    end
                end
                
                START_BIT: begin
                    state <= DATA_BIT;
                    received_byte <= in;
                    done <= 0;
                end
                
                DATA_BIT: begin
                    if (received_byte < 8) begin
	                    state <= DATA_BIT;
	                    received_byte <= {received_byte[6:0], in};
	                    done <= 0;
                    end else begin
	                    state <= STOP_BIT;
	                    done <= 0;
                    end
                end
                
                STOP_BIT: begin
                    if (in == 1'b1) begin
                        state <= IDLE;
                        out_byte <= received_byte;
                        done <= 1;
                    end
                end
            endcase
        end
    end
endmodule
