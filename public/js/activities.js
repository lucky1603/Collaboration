/**
 * @name activities.js
 * @description File that handles the 'activity' entries.
 * @author sinisa <sinisa.ristic@gmail.com>
 * @date 14.11.2017.
 */

/**
 * Inicijalizacija posle load-ovanja dokumenta.
 */
$('#tab3').ready(function(){	
	initEntries();
	$('#section_id').on('change', function(evt) {
		var section = $('#section_id option:selected').val();
		getActivities(section);
	});
});

/**
 * Inicijalizuje listu sekcija.
 * @returns
 */
function initEntries()
{
	$.get("/ajax/get_activity_sections", function(data) {
		$("#section_id").empty();				        	
		var podaci = JSON.parse(data);
		$.each(podaci, function(idx, val) {	
			var section = val;
			$('#section_id').append($("<option></option>").attr('value', section.key).text(section.value));
			
		});
		
		var current = $("#section_id option:selected").val();
		getActivities(current);
	});
	
	
}

/**
 * Vraca listu aktivnosti za izabranu sekciju.
 * @param section
 * @returns
 */
function getActivities(section)
{
	$("#activity_id").empty();
	$.post('/ajax/get_activities', {section: section}, function(data) {
		var activities = JSON.parse(data);
		$.each(activities, function(idx, val) {
			var activity = val;
			$('#activity_id').append($("<option></option>").attr('value', activity.id).text(activity.description));
		});
	})
}