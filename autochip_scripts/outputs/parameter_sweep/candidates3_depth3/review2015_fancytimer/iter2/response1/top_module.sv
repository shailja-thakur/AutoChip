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
    reg [15:0] counter;
    reg check_start_seq;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            counting <= 0;
            done <= 0;
            counter <= 0;
            check_start_seq <= 0;
        end else begin
            case (state)
                3'b000: begin
                    // Searching for start sequence 1101.
                    if (data == 4'b1101) begin
                        state <= 3'b001;
                        check_start_seq <= 0;
                    end else begin
                        check_start_seq <= 1;
                    end
                end
                3'b001: begin
                    // Shifting in the next 4 bits to determine the delay.
                    delay <= {data, delay[3:1]};
                    state <= 3'b010;
                end
                3'b010: begin
                    // Waiting for countdown to finish.
                    counting <= 1;
                    if (counter < (delay + 1) * 1000 - 1) begin
                        counter <= counter + 1;
                    end else begin
                        state <= 3'b011;
                        counter <= 0;
                    end
                end
                3'b011: begin
                    // Notifying user and waiting for acknowledgement.
                    done <= 1;
                    counting <= 0;
                    if (ack) begin
                        state <= 3'b000;
                    end
                end
                default: begin
                    state <= 3'b000;
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            count <= 4'bxxxx;
        end else if (counting) begin
            count <= delay;
        end else begin
            count <= 4'bxxxx;
        end
    end

endmodule
