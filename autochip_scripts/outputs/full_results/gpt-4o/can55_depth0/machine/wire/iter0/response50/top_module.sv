module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out);

    // State encoding
    localparam IDLE    = 2'b00,
               WAIT    = 2'b01,
               PROCESS = 2'b10,
               DONE    = 2'b11;

    // Internal signals
    reg [1:0] state;
    reg [3:0] counter; // Counter to keep track of clock cycles

    // Threshold value for state transition from WAIT to PROCESS
    localparam THRESHOLD = 4'd10;

    // Sequential logic for state transitions and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0;
            data_out <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 4'b0;
                    data_out <= 8'b0;
                    valid_out <= 1'b0;
                    state <= WAIT;
                end
                
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b0;
                    if (counter == THRESHOLD) begin
                        state <= PROCESS;
                    end
                end
                
                PROCESS: begin
                    data_out <= 8'hA5; // Example processed data
                    state <= DONE;
                end
                
                DONE: begin
                    valid_out <= 1'b1;
                    state <= IDLE;
                end
                
                default: state <= IDLE;
            endcase
        end
    end
endmodule
