module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [1:0] state, nextState;
    reg [1:0] w_history;
    integer count;

    // reset state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
        end else begin
            state <= nextState;
        end
    end

    // state transition and output logic
    always @(posedge clk) begin
        case(state)
            2'b00: begin // State A
                if (s) begin
                    nextState = 2'b01; // Move to State B
                end else begin
                    nextState = 2'b00; // Stay in State A
                end
                z <= 0;
            end

            2'b01: begin // State B
                if (count == 2) begin
                    if (w_history[1] == 1 && w_history[0] == 1) begin
                        nextState = 2'b11; // Move to State D
                        z <= 1;
                    end else begin
                        nextState = 2'b10; // Move to State C
                        z <= 0;
                    end
                    count <= 0;
                end else begin
                    nextState = 2'b01; // Stay in State B
                    z <= 0;
                    if (w == 1) begin
                        count <= count + 1;
                    end
                end
                w_history <= {w_history[0], w};
            end

            2'b10: begin // State C
                if (count == 2) begin
                    if (w_history[1] == 1 && w_history[0] == 1) begin
                        nextState = 2'b11; // Move to State D
                        z <= 1;
                    end else begin
                        nextState = 2'b01; // Move to State B
                        z <= 0;
                    end
                    count <= 0;
                end else begin
                    nextState = 2'b10; // Stay in State C
                    z <= 0;
                    if (w == 1) begin
                        count <= count + 1;
                    end
                end
                w_history <= {w_history[0], w};
            end

            2'b11: begin // State D
                if (count == 2) begin
                    if (w_history[1] == 1 && w_history[0] == 1) begin
                        nextState = 2'b11; // Stay in State D
                        z <= 1;
                    end else begin
                        nextState = 2'b01; // Move to State B
                        z <= 0;
                    end
                    count <= 0;
                end else begin
                    nextState = 2'b11; // Stay in State D
                    z <= 0;
                    if (w == 1) begin
                        count <= count + 1;
                    end
                end
                w_history <= {w_history[0], w};
            end

            default: begin // Invalid state
                nextState = 2'b00; // Reset to State A
                z <= 0;
            end
        endcase
    end

    // initialize variables
    initial begin
        state = 2'b00;
        nextState = 2'b00;
        w_history = 2'b00;
        count = 0;
    end

endmodule
