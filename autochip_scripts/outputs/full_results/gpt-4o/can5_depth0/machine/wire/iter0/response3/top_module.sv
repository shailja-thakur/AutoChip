module top_module (
    input wire clock,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    reg [7:0] counter;
    reg [7:0] data;
    state_t state;

    // Sequential block for state transitions and output logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Reset logic
            state <= IDLE;
            counter <= 8'b0;
            data_out <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    // IDLE state logic
                    counter <= 8'b0;
                    data_out <= 8'b0;
                    valid_out <= 1'b0;
                    state <= WAIT;
                end
                
                WAIT: begin
                    // WAIT state logic
                    counter <= counter + 1;
                    data_out <= 8'b0;
                    if (counter == 8'd255) begin // Example threshold, adjust as needed
                        state <= PROCESS;
                    end
                end
                
                PROCESS: begin
                    // PROCESS state logic
                    data_out <= data; // Process data and assign to data_out, customize as needed
                    state <= DONE;
                end
                
                DONE: begin
                    // DONE state logic
                    valid_out <= 1'b1;
                    state <= IDLE;
                end
                
                default: begin
                    // Default case
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
