module top_module (
    input d,
    input ena,
    output logic q
);

    // Internal storage for output q
    logic q_next;

    always_comb begin
        if (ena)
            q_next = d;
        else
            q_next = q;
    end

    // Process to update output
    always_ff @ (posedge ena or negedge ena) begin
        q <= q_next;
    end

endmodule
