module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    localparam IDLE = 0;
    localparam STATE_1 = 1;
    localparam STATE_2 = 2;
    localparam STATE_3 = 3;

    // Define the state register
    reg [1:0] current_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1;
        end else begin
            case (current_state)
                IDLE: begin
                    if (train_valid) begin
                        if (train_taken && (current_state < STATE_3)) begin
                            current_state <= current_state + 1;
                        end else if (!train_taken && (current_state > IDLE)) begin
                            current_state <= current_state - 1;
                        end
                    end
                end
                default: begin
                    // Remain in the current state
                    current_state <= current_state;
                end
            endcase
        end
    end

    // Assign the output state based on the current state
    always @* begin
        case (current_state)
            IDLE: state = 2'b00;
            STATE_1: state = 2'b01;
            STATE_2: state = 2'b10;
            STATE_3: state = 2'b11;
        endcase
    end

endmodule
