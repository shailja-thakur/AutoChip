module top_module(
    input clock,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Define states using parameter
    parameter IDLE = 2'b00, WAIT = 2'b01, PROCESS = 2'b10, DONE = 2'b11;

    // Internal signals
    reg [1:0] state;
    reg [3:0] counter; // Assuming 4-bit counter for demonstration

    // Initialize state and counter
    initial begin
        state = IDLE;
        counter = 4'd0;
        data_out = 8'd0;
        valid_out = 1'b0;
    end

    // FSM Implementation
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 4'd0;
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'd0;
                    if(counter == 4'd10) begin // Assuming threshold as 10 for demonstration 
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    data_out <= 8'hFF; // Example processed data
                    state <= DONE;
                end
                DONE: begin
                    valid_out <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
