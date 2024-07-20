module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum logic [1:0] {
        LOW = 2'b00,
        MID = 2'b01,
        HIGH = 2'b10,
        MAX = 2'b11
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= LOW;
        else
            current_state <= next_state;
    end

    always_comb begin
        // Default output values
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;
        next_state = current_state;

        case (current_state)
            LOW: begin
                if (s[1]) 
                    next_state = MID;
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                dfr = 1'b1;
            end
            MID: begin
                if (s[2])
                    next_state = HIGH;
                else if (!s[1])
                    next_state = LOW;
                fr1 = 1'b1;
                fr2 = 1'b1;
            end
            HIGH: begin
                if (s[3])
                    next_state = MAX;
                else if (!s[2])
                    next_state = MID;
                fr1 = 1'b1;
            end
            MAX: begin
                if (!s[3])
                    next_state = HIGH;
            end
        endcase

        // Determine dfr based on state transitions
        if (next_state > current_state) begin
            dfr = 1'b1;
        end
    end
endmodule
