module top_module(
    input wire clk,
    input wire reset,
    output wire data_out,
    output wire valid_out);

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;
    wire clk_edge;

    // Generate a clock edge signal for sensitive posedge clk
    always @(posedge clk) begin
        clk_edge <= ~clk_edge;
    end

    // FSM
    always @(posedge clk_edge or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            counter <= 8'b0;
            data_out <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                0: begin // Idle state
                    if (reset) begin
                        state <= 2'b00;
                        counter <= 8'b0;
                        data_out <= 8'b0;
                        valid_out <= 1'b0;
                    end else begin
                        state <= 2'b01; // Wait state
                        counter <= 8'b0;
                        data_out <= 8'b0;
                        valid_out <= 1'b0;
                    end
                end
                1: begin // Wait state
                    if (counter == 8'b11111111) begin // Threshold reached
                        state <= 2'b10; // Process state
                        data_out <= data;
                    end else begin
                        state <= 2'b01; // Wait state
                        counter <= counter + 1;
                        data_out <= 8'b0;
                    end
                end
                2: begin // Process state
                    state <= 2'b11; // Done state
                end
                3: begin // Done state
                    state <= 2'b00; // Idle state
                    valid_out <= 1'b1;
                end
                default: begin
                    state <= 2'b00; // Idle state (default case)
                end
            endcase
        end
    end

endmodule
