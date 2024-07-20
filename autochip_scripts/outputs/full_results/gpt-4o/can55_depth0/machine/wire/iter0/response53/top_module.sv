module top_module (
    input wire clk,
    input wire reset,
    output reg data,
    output reg valid
);
    // Declare state encoding
    typedef enum reg [1:0] {
        idle = 2'b00,
        wait = 2'b01,
        process = 2'b10,
        done = 2'b11
    } state_t;

    // Internal signals
    reg [1:0] state;
    reg [3:0] counter; // Counter to track clock cycles

    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= idle;
            counter <= 4'd0;
            data <= 1'b0;
            valid <= 1'b0;
        end else begin
            case(state)
                idle: begin
                    counter <= 4'd0;
                    data <= 1'b0;
                    valid <= 1'b0;
                    state <= wait;
                end

                wait: begin
                    if (counter == 4'd9) begin  // Assuming threshold is 10 cycles
                        state <= process;
                    end else begin
                        counter <= counter + 1;
                        data <= 1'b0;
                        valid <= 1'b0;
                    end
                end

                process: begin
                    data <= 1'b1; // Assign processed data to 1 for example
                    state <= done;
                end

                done: begin
                    valid <= 1'b1;
                    state <= idle;
                end

                default: state <= idle;
            endcase
        end
    end

endmodule
