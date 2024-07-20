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
        if (reset) begin
            state <= 2'b00;
            counting <= 0;
            done <= 0;
            counter <= 0;
            delay <= 0;
        end else begin
            case (state)
                2'b00: begin // Search for start sequence
                    if (data == 4'b1101) begin
                        state <= 2'b01;
                        counting <= 0;
                        done <= 0;
                        counter <= 0;
                    end
                end
                2'b01: begin // Shift in delay bits
                    delay <= {data, delay[3:1]};
                    state <= 2'b10;
                end
                2'b10: begin // Wait for delay time
                    if (counter == delay) begin
                        state <= 2'b11;
                        counting <= 1;
                        counter <= 0;
                    end else begin
                        counter <= counter + 1;
                    end
                end
                2'b11: begin // Counting
                    if (counter == (delay + 1)) begin
                        state <= 2'b00;
                        counting <= 0;
                        done <= 1;
                        counter <= 0;
                    end else begin
                        counter <= counter + 1;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            count <= 4'bxxxx;
        end else begin
            if (counting) begin
                count <= delay - counter;
            end else begin
                count <= 4'bxxxx;
            end
        end
    end
endmodule
