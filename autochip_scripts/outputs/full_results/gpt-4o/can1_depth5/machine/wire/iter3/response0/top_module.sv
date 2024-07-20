module top_module(
    input clk,
    input rst,
    output reg [7:0] data_out,
    output reg valid_out
);

    reg [1:0] state;
    reg [7:0] counter;

    localparam IDLE = 2'b00;
    localparam WAIT = 2'b01;
    localparam PROCESS = 2'b10;
    localparam DONE = 2'b11;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset state and outputs
            state <= IDLE;
            counter <= 8'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    // Initial state
                    counter <= 0;
                    data_out <= 0;
                    valid_out <= 1'b0;
                    state <= WAIT;
                end

                WAIT: begin
                    // Increment counter
                    counter <= counter + 1;
                    data_out <= 0;
                    if (counter >= 8'd255) begin
                        state <= PROCESS;
                    end
                end

                PROCESS: begin
                    // Process data
                    data_out <= counter;  // Just an example, replace with actual processing logic
                    state <= DONE;
                end

                DONE: begin
                    // Set valid output
                    valid_out <= 1'b1;
                    state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
