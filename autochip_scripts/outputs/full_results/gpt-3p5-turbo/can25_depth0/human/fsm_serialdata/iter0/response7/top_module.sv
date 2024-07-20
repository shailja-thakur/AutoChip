module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [3:0] state;
reg [7:0] data_byte;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        data_byte <= 0;
    end else begin
        case (state)
            0: begin // Idle state
                if (in == 1) begin
                    state <= 1; // Transition to start bit state
                end
            end
            1: begin // Start bit state
                if (in == 0) begin
                    state <= 2; // Transition to data bits state
                    data_byte <= 0; // Reset data byte
                end else begin
                    state <= 0; // Transition back to idle state
                    data_byte <= 0; // Reset data byte
                end
            end
            2: begin // Data bits state
                if (in == 0) begin
                    data_byte <= {in, data_byte[7:1]}; // Shift in data bit
                end else begin
                    state <= 3; // Transition to stop bit state
                end
            end
            3: begin // Stop bit state
                if (in == 1) begin
                    state <= 0; // Transition back to idle state
                    out_byte <= data_byte; // Output data byte
                    done <= 1; // Assert done
                end
            end
        endcase
    end
end

endmodule
