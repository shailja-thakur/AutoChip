module top_module(
    input in,
    output out);

    // Internal signals
    reg clk;
    reg reset;
    reg data_out;
    reg valid_out;
    reg [1:0] state;
    reg [3:0] counter;
    reg out;

    // State encoding
    localparam IDLE    = 2'b00,
               WAIT    = 2'b01,
               PROCESS = 2'b10,
               DONE    = 2'b11;

    // Stimulus generator to mimic clock and reset signals for simulation
    always begin
        #5 clk = ~clk;  // Toggle clock every 5 time units for simulation
    end

    initial begin
        clk = 0;
        reset = 1;  // Assert reset initially
        #10 reset = 0;  // Deassert reset after 10 time units
    end

    // State Machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
            data_out <= 0;
            valid_out <= 0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 4'b0000;
                    data_out <= 0;
                    valid_out <= 0;
                    state <= WAIT;
                end

                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 0;
                    valid_out <= 0;
                    if (counter == 4'b1111) begin
                        state <= PROCESS;
                    end
                end

                PROCESS: begin
                    // Add your data processing here
                    data_out <= 4'b1010; // Example processed data
                    state <= DONE;
                end

                DONE: begin
                    valid_out <= 1;
                    state <= IDLE;
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
    
    // Assign module output based on internal signals
    assign out = data_out;

endmodule
