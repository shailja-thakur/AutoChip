module top_module(
    input clock,
    input reset,
    output reg [7:0] data_output,
    output reg valid_output
);

reg [1:0] state;
reg [7:0] counter;

always @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= 0; // Idle state
        counter <= 0;
        data_output <= 0;
        valid_output <= 0;
    end
    else begin
        case (state)
            0: begin // Idle state
                counter <= 0;
                data_output <= 0;
                valid_output <= 0;
                state <= 1; // Transition to Wait state
            end
            1: begin // Wait state
                counter <= counter + 1;
                data_output <= 0;
                if (counter == 8'hFF) begin
                    state <= 2; // Transition to Process state
                end
            end
            2: begin // Process state
                data_output <= 8'hA5; // Set the data output
                state <= 3; // Transition to Done state
            end
            3: begin // Done state
                valid_output <= 1; // Assert the valid output
                state <= 0; // Transition back to Idle state
            end
        endcase
    end
end

endmodule
