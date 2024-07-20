module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    // Internal signals and registers
    reg [2:0] state;
    reg [4:0] delay;
    reg [9:0] counter;
    reg start_sequence_detected;
    
    // Constants
    localparam IDLE = 3'b000;
    localparam RECEIVE_DATA = 3'b001;
    localparam COUNTING = 3'b010;
    localparam WAIT_ACK = 3'b011;
    
    // State machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            counter <= 0;
            delay <= 0;
            start_sequence_detected <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    counting <= 0;
                    done <= 0;
                    
                    if (data == 1'b1 && start_sequence_detected == 0) begin
                        state <= RECEIVE_DATA;
                    end
                    else begin
                        state <= IDLE;
                    end

                    start_sequence_detected <= (data == 1'b1) ? 1 : 0;
                end
                
                RECEIVE_DATA: begin
                    counting <= 0;
                    done <= 0;
                    
                    // Shift in 4 more bits to determine delay
                    delay <= {delay[2:0], data};
                    
                    if (delay == 4'b1101) begin
                        state <= COUNTING;
                    end
                    else begin
                        state <= IDLE;
                    end
                end
                
                COUNTING: begin
                    counting <= 1;
                    done <= 0;
                    count <= delay;
                    counter <= counter + 1;
                    
                    if (counter >= (delay + 1) * 1000 - 1) begin
                        state <= WAIT_ACK;
                    end
                    else begin
                        state <= COUNTING;
                    end
                end
                
                WAIT_ACK: begin
                    counting <= 0;
                    
                    if (ack == 1'b1) begin
                        done <= 1;
                        state <= IDLE;
                    end
                    else begin
                        done <= 0;
                        state <= WAIT_ACK;
                    end
                end
            endcase
        end
    end
endmodule
