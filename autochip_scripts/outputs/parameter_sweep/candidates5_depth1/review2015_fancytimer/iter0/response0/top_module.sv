module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output wire counting,
    output wire done,
    input wire ack );
    
    reg [3:0] delay;
    reg [2:0] state;
    reg [11:0] counter;
    reg detect_pattern;
    reg start_count;

  	always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            count <= 4'b0;
            counter <= 12'b0;
            detect_pattern <= 0;
            start_count <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case(state)
                0: begin
                    if (data) begin
                        detect_pattern <= 1;
                        state <= 1;
                        counter <= 12'b1;
                        counting <= 0;
                        done <= 0;
                    end
                end
                1: begin
                    if (counter == 12'b10) begin
                        detect_pattern <= 0;
                        state <= 2;
                        counter <= 12'b0;
                        counting <= 0;
                        done <= 0;
                    end else begin
                        counter <= counter + 1;
                    end
                end
                2: begin
                    if (detect_pattern) begin
                        state <= 1;
                        counter <= 12'b1;
                        counting <= 0;
                        done <= 0;
                    end else begin
                        delay <= data[3:0];
                        state <= 3;
                        counter <= 12'b0;
                        counting <= 1;
                        done <= 0;
                    end
                end
                3: begin
                    if (counter == ((delay + 1) * 1000) - 1) begin
                        counting <= 0;
                        done <= 1;
                    end else begin
                        counter <= counter + 1;
                    end
                end
                default: state <= 0;
            endcase
        end
    end
    
    assign count = counting ? delay : 4'b0;
  
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            start_count <= 0;
        end else begin
            if (done && ack) begin
                start_count <= 1;
            end else begin
                start_count <= detect_pattern ? 0 : start_count;
            end
        end
    end

    initial begin
        done <= 0;
    end
  
endmodule
