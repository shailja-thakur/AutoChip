module top_module(
    input clk,
    input reset,
    output shift_ena,
    output [2:0] state
);

    // State declarations
    localparam [2:0] B0 = 3'b000,
                     B1 = 3'b001,
                     B2 = 3'b010,
                     B3 = 3'b011,
                     Done = 3'b100;

    // State register
    reg [2:0] current_state, next_state;

    // Sequential logic: state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= B0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic: next state logic
    always @(*) begin
        case (current_state)
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = Done;
            default: next_state = Done;
        endcase
    end

    // Output logic
    assign shift_ena = (current_state == B0) || (current_state == B1) || 
                       (current_state == B2) || (current_state == B3);
    
    assign state = current_state;

endmodule
