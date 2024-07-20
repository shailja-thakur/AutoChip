module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [3:0] delay;
    reg [3:0] counter;
    reg [1:0] state;
    
    always @(posedge clk) begin
      
        if(reset) begin
            state <= 2'b00;
            delay <= 4'b0;
            counter <= 4'b0;
            count <= 4'b0;
            counting <= 0;
            done <= 0;
        end else begin
            case(state)
                2'b00: // Searching for 1101
                    if(data == 4'b1101) begin
                        state <= 2'b01;
                    end
                2'b01: // Shifting in 4 bits
                    delay <= {delay[2:0], data};
                    state <= 2'b10;
                    counting <= 1;
                2'b10: // Counting
                    if(counter == (delay + 1)) begin
                        counting <= 0;
                        done <= 1;
                    end else begin
                        count <= delay - counter;
                        counter <= counter + 1;
                    end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if(ack == 1) begin
            done <= 0;
        end
    end
    
endmodule
