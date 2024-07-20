module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [2:0] state;
    reg [3:0] delay;
    reg [9:0] counter;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0; // reset to initial state
            counting <= 0; // stop counting
            done <= 0; // clear done signal
            counter <= 0; // clear counter value
        end
        else begin
            case (state)
                0: begin
                    if (data == 1 && counter == 1) begin // start of pattern detected
                        state <= 1; // transition to state 1
                        counter <= 0; // reset counter
                    end
                    else begin
                        counter <= counter + 1; // increment counter
                    end
                end
                1: begin
                    delay[3] <= data; // store first bit of delay duration
                    state <= 2; // transition to state 2
                end
                2: begin
                    delay[2] <= data; // store second bit of delay duration
                    state <= 3; // transition to state 3
                end
                3: begin
                    delay[1] <= data; // store third bit of delay duration
                    state <= 4; // transition to state 4
                end
                4: begin
                    delay[0] <= data; // store fourth bit of delay duration
                    state <= 5; // transition to state 5
                end
                5: begin
                    counting <= 1; // start counting
                    counter <= counter + 1; // increment counter
                    if (counter == (delay + 1) * 1000) begin // delay duration reached
                        state <= 6; // transition to state 6
                    end
                end
                6: begin
                    if (ack == 1) begin // acknowledge received
                        done <= 1; // set done signal
                        counting <= 0; // stop counting
                        counter <= 0; // reset counter
                        state <= 0; // transition to initial state
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            count <= 0; // reset count value
        end
        else begin
            if (counting) begin
                count <= delay; // set count value as delay duration
            end
            else begin
                count <= 0; // clear count value
            end
        end
    end
    
endmodule
