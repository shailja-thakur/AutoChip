module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Declare the state machine flip-flops
reg [5:0] next_state, current_state;

// Assign the initial state
initial
    current_state = 6'b000001;

// Assign the next state based on the current state and input
always @(*)
begin
    case (current_state)
        6'b000001:
            if (w)
                next_state = 6'b000010;
            else
                next_state = 6'b000001;
        6'b000010:
            if (w)
                next_state = 6'b000100;
            else
                next_state = 6'b001000;
        6'b000100:
            if (w)
                next_state = 6'b010000;
            else
                next_state = 6'b001000;
        6'b001000:
            if (w)
                next_state = 6'b100000;
            else
                next_state = 6'b000001;
        6'b010000:
            if (w)
                next_state = 6'b010000;
            else
                next_state = 6'b001000;
        6'b100000:
            if (w)
                next_state = 6'b000100;
            else
                next_state = 6'b001000;
    endcase
end

// Assign the output signals based on the current state
always @(current_state)
begin
    Y1 = (current_state == 6'b000010) || (current_state == 6'b000100) || (current_state == 6'b100000);
    Y3 = (current_state == 6'b000100) || (current_state == 6'b010000) || (current_state == 6'b100000);
end

// Update the current state with the next state
always @(posedge w)
begin
    current_state <= next_state;
end

endmodule
