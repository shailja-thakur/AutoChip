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
reg start_sequence;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        start_sequence <= 0;
        counting <= 0;
        done <= 0;
        delay <= 4'b0000;
        counter <= 4'b0000;
    end else begin
        case (state)
            2'b00: begin
                if (data == 1'b1)
                    start_sequence <= 1;
                else
                    start_sequence <= 0;
                
                if (start_sequence && data == 1'b0)
                    state <= 2'b01;
            end
            2'b01: begin
                state <= 2'b10;
                delay <= {data, data, data, data};
            end
            2'b10: begin
                state <= 2'b11;
                counting <= 1;
                counter <= delay;
            end
            2'b11: begin
                if (ack) begin
                    state <= 2'b00;
                    counting <= 0;
                    done <= 1;
                end else if (counter == 0) begin
                    state <= 2'b00;
                    counting <= 0;
                    done <= 1;
                end else begin
                    counter <= counter - 1;
                end
            end
        endcase
    end
end

assign count = counter;

endmodule
