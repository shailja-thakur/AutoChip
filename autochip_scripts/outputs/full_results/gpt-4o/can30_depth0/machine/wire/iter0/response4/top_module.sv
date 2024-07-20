module top_module(
    input clock,
    input reset,
    output reg data_out,
    output reg valid_out
);

    reg [1:0] state;       // State register
    reg [3:0] counter;     // Counter register

    // State encoding
    localparam IDLE    = 2'b00,
               WAIT    = 2'b01,
               PROCESS = 2'b10,
               DONE    = 2'b11;

    // State transitions and output logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Reset state and outputs
            state <= IDLE;
            counter <= 4'b0000;
            data_out <= 0;
            valid_out <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    // Initial state
                    counter <= 4'b0000;
                    data_out <= 0;
                    valid_out <= 0;
                    state <= WAIT;
                end
                
                WAIT: begin
                    // Wait state
                    counter <= counter + 1;
                    data_out <= 0;
                    if (counter == 4'b1111)  // Example threshold
                        state <= PROCESS;
                end
                
                PROCESS: begin
                    // Process data
                    data_out <= <data_value>;  // Replace with actual data processing logic
                    valid_out <= 1;
                    state <= DONE;
                end
                
                DONE: begin
                    // Data valid
                    valid_out <= 1;
                    state <= IDLE;
                end
                
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
