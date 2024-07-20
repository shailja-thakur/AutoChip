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
    reg start_sequence;

    always @(posedge clk) begin
        if (reset) begin
            // Reset the circuit
            counting <= 0;
            done <= 0;
            delay <= 0;
            counter <= 0;
            start_sequence <= 0;
        end else begin
            if (start_sequence) begin
                // Wait for the delay period
                if (counter < (delay + 1) * 1000) begin
                    counting <= 1;
                    counter <= counter + 1;
                end else begin
                    // Done counting, notify user
                    counting <= 0;
                    done <= 1;
                end
            end else begin
                // Look for start sequence (1101)
                if (data == 4'b1101) begin
                    start_sequence <= 1;
                    delay <= data[3:0];
                    counter <= 0;
                end else begin
                    start_sequence <= 0;
                end
            end
        end
    end
    
    assign count = start_sequence ? delay - (counter / 1000) : 4'bzzzz;
    
    always @(posedge clk) begin
        if (ack) begin
            // Reset the circuit after acknowledgement
            counting <= 0;
            done <= 0;
            delay <= 0;
            counter <= 0;
            start_sequence <= 0;
        end
    end
endmodule
