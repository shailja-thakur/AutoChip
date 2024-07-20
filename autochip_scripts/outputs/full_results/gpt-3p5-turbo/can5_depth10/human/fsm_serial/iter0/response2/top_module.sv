module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [3:0] state;
    reg start;
    reg [7:0] data;
    reg stop;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            start <= 0;
            data <= 0;
            stop <= 1;
            done <= 0;
        end
        else begin
            case (state)
                0: begin  // Idle state
                    if (in == 0) begin
                        state <= 1;
                        start <= 1;
                    end
                end
                1: begin  // Start bit detected
                    state <= 2;
                end
                2: begin  // Receive data bits
                    state <= 3;
                    data <= {data[6:0], in};
                end
                3: begin  // Check for stop bit
                    if (in == 1) begin
                        state <= 4;
                    end
                end
                4: begin  // Stop bit detected
                    state <= 0;
                    start <= 0;
                    stop <= 1;
                    done <= 1;
                end
                default: state <= 0;
            endcase
        end
    end

endmodule
